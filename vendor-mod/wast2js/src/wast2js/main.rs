// Modified for Scrasm: runtime API and harness integration; see ../../NOTICE.md.
/* Copyright 2021 Mozilla Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

use anyhow::{Context as _, Result, bail};
use std::path::Path;
use wast2js::{JsRuntime, convert};

fn main() -> Result<()> {
    let mut args = std::env::args().skip(1);
    let mut target = JsRuntime::SpiderMonkey;
    let mut files = Vec::new();

    while let Some(arg) = args.next() {
        if let Some(value) = arg.strip_prefix("--target=") {
            target = parse_target(value)?;
            continue;
        }
        if arg == "--target" {
            let value = args.next().context("missing value for --target")?;
            target = parse_target(&value)?;
            continue;
        }
        if arg.starts_with('-') {
            bail!("unknown flag `{arg}`");
        }
        files.push(arg);
    }

    for path in files {
        let source = std::fs::read_to_string(&path)
            .with_context(|| format!("failed to read `{path}`"))?;
        let full_script = convert(target, &path, &source)?.into_standalone_script()?;

        let output_path = Path::new(&path).with_extension("js");
        let output_name = output_path
            .file_name()
            .context("failed to determine output file name")?;
        std::fs::write(output_name, full_script)
            .with_context(|| format!("failed to write `{}`", output_name.display()))?;
    }

    Ok(())
}

fn parse_target(value: &str) -> Result<JsRuntime> {
    match value {
        "spidermonkey" => Ok(JsRuntime::SpiderMonkey),
        "v8" => Ok(JsRuntime::V8),
        _ => bail!("unknown target `{value}`, expected `spidermonkey` or `v8`"),
    }
}
