pub struct EncryptedString {
    pub global_id: GlobalId,
    pub data_id: DataId,
    pub data_len: usize,
    pub key_offset: usize,
    pub active_mem: Option<(MemId, Expression)>,
    pub is_64: bool,
}
