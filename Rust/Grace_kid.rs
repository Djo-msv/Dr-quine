use std::fs::File;
use std::io::Write;

fn main() -> std::io::Result<()> {
    let src = r#"use std::fs::File;
use std::io::Write;

fn main() -> std::io::Result<()> {
    let src = r$"^"$;
    let mut file = File::create("Grace_kid.rs")?;
    write!(file, "{}", src.replace('\u{24}', "$").replace('\u{5e}', src))?;
    Ok(())
}
"#;
    let mut file = File::create("Grace_kid.rs")?;
    write!(file, "{}", src.replace('\u{24}', "#").replace('\u{5e}', src))?;
    Ok(())
}
