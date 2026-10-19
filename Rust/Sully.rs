use std::fs::File;
use std::io::Write;
use std::process::Command;

fn main() -> std::io::Result<()> {
    let mut i = 5;
    let src = r#"use std::fs::File;
use std::io::Write;
use std::process::Command;

fn main() -> std::io::Result<()> {
    let mut i = %;
    let src = r$"^"$;
    i -= 1;
    let filename = format!("Sully_{}.rs", i);
    if i < 0 {
        std::process::exit(1);
    }
    let mut file = File::create(filename.clone())?;
    write!(file, "{}", src.replace('\u{25}', &i.to_string()).replace('\u{24}', "$").replace('\u{5e}', src))?;

    let _ = Command::new("rustc").args(&[filename, "-o".to_string(), "Sully".to_string()]).status();
    _ = Command::new("./Sully").status();
    Ok(())
}
"#;
    i -= 1;
    let filename = format!("Sully_{}.rs", i);
    if i < 0 {
        std::process::exit(1);
    }
    let mut file = File::create(filename.clone())?;
    write!(file, "{}", src.replace('\u{25}', &i.to_string()).replace('\u{24}', "#").replace('\u{5e}', src))?;

    let _ = Command::new("rustc").args(&[filename, "-o".to_string(), "Sully".to_string()]).status();
    _ = Command::new("./Sully").status();
    Ok(())
}
