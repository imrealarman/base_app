/// Compares two file paths for equality, ignoring `/` vs `\` separator differences.
///
/// Windows accepts either separator, but string-interpolated paths built from
/// `Directory.current.path` combined with `Directory.listSync()` results can end up
/// mixing the two for the same logical path, which breaks naive `==` comparisons.
bool samePath(String a, String b) =>
    a.replaceAll('\\', '/') == b.replaceAll('\\', '/');
