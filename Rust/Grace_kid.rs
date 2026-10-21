use std::fs::File;
use std::io::Write;

macro_rules! _program {
    () => {
        let src = r#"use std::fs::File;
use std::io::Write;

macro_rules! _program {
    () => {
        let src = r$"^"$;
        let mut file = File::create("Grace_kid.rs")?;
        write!(file, "{}", src.replace('\u{24}', "$").replace('\u{5e}', src))?;
    };
}

// This is the only authorized program comment
fn main() -> std::io::Result<()> {
    _program!();
    Ok(())
}
"#;
        let mut file = File::create("Grace_kid.rs")?;
        write!(file, "{}", src.replace('\u{24}', "#").replace('\u{5e}', src))?;
    };
}

// This is the only authorized program comment
fn main() -> std::io::Result<()> {
    _program!();
    Ok(())
}
