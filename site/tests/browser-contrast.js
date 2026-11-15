export function checkTextContrast() {
  const rgba = (value) => {
    const channels = value.match(/[\d.]+/g)?.map(Number);
    if (!channels || channels.length < 3) throw new Error(`Unsupported color: ${value}`);
    return [...channels.slice(0, 3), channels[3] ?? 1];
  };
  const blend = (front, back) =>
    front.slice(0, 3).map((channel, i) => channel * front[3] + back[i] * (1 - front[3]));
  const background = (element) => {
    if (!element) return [255, 255, 255];
    const color = rgba(getComputedStyle(element).backgroundColor);
    return blend(color, color[3] === 1 ? [255, 255, 255] : background(element.parentElement));
  };
  const luminance = (color) =>
    color
      .map((channel) => {
        const normalized = channel / 255;
        return normalized <= 0.04045 ? normalized / 12.92 : ((normalized + 0.055) / 1.055) ** 2.4;
      })
      .reduce((sum, channel, i) => sum + channel * [0.2126, 0.7152, 0.0722][i], 0);
  const failures = [];
  let minimum = Infinity;
  let checked = 0;
  const check = (element, text, pseudo) => {
    if (
      !element.checkVisibility({
        checkOpacity: true,
        checkVisibilityCSS: true,
      }) ||
      element.closest(":disabled")
    )
      return;
    const back = background(element);
    const front = blend(rgba(getComputedStyle(element, pseudo).color), back);
    const a = luminance(front),
      b = luminance(back);
    const ratio = (Math.max(a, b) + 0.05) / (Math.min(a, b) + 0.05);
    checked++;
    minimum = Math.min(minimum, ratio);
    if (ratio < 7)
      failures.push({
        element: element.id || element.className,
        text: text.slice(0, 65),
        ratio,
      });
  };
  const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  while (walker.nextNode()) {
    const text = walker.currentNode.textContent.trim();
    const element = walker.currentNode.parentElement;
    if (text && !element.closest("script,style,.visually-hidden,svg")) check(element, text);
  }
  for (const element of document.querySelectorAll("input[type=text],textarea")) {
    if (element.value) check(element, element.value);
    else if (element.placeholder) check(element, element.placeholder, "::placeholder");
  }
  if (failures.length) throw new Error(JSON.stringify(failures));
  return { checked, minimumRatio: minimum };
}
