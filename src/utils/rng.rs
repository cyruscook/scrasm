use anyhow::anyhow;
use std::ops::{BitOr, Shl};

pub fn read_num<O, D, R>(rng: &mut rand::distr::Iter<D, R, u8>) -> anyhow::Result<O>
where
    D: rand::distr::Distribution<u8>,
    R: rand::Rng,
    O: Default
        + Shl<O, Output = O>
        + TryFrom<usize, Error: Send + Sync + std::error::Error + 'static>
        + From<u8>,
    <O as Shl>::Output: BitOr<O, Output = O>,
{
    let num_bytes = std::mem::size_of::<O>();
    let bytes = rng.take(num_bytes).enumerate();
    let mut out: O = O::default();
    for (i, byte) in bytes {
        let shift_by: usize = i.checked_mul(8).ok_or_else(|| anyhow!("failed to mul"))?;
        let shift_by: O = shift_by.try_into()?;
        let shifted: O = out.shl(shift_by);
        let byte: O = byte.into();
        out = shifted | byte;
    }
    Ok(out)
}

pub fn read_nums<O, D, R>(
    rng: &mut rand::distr::Iter<D, R, u8>,
    num: usize,
) -> anyhow::Result<Vec<O>>
where
    D: rand::distr::Distribution<u8>,
    R: rand::Rng,
    O: Default
        + Shl<O, Output = O>
        + TryFrom<usize, Error: Send + Sync + std::error::Error + 'static>
        + From<u8>,
    <O as Shl>::Output: BitOr<O, Output = O>,
{
    let mut out = Vec::with_capacity(num);
    for _ in 0..num {
        out.push(read_num(rng)?);
    }
    Ok(out)
}
