// comment present outside of the program
fn do_stuff() {
    for _i in 1..101 {}
}

fn main() {
    // comment present inside the main function
    let src = r#"// comment present outside of the program
fn do_stuff() {
    for _i in 1..101 {}
}

fn main() {
    // comment present inside the main function
    let src = r$"?"$;
    do_stuff();
    println!("{}", src.replace('\u{24}', "$").replace('\u{3f}', src));
}"#;
    do_stuff();
    println!("{}", src.replace('\u{24}', "#").replace('\u{3f}', src));
}
