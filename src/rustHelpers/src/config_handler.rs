use std::fs::{read_to_string, write};
use std::path::PathBuf;
use std::io;
use std::env;

pub fn save_option(option: &str, new_value: &str) -> io::Result<()> {
    let path = PathBuf::from("../config.ini");
    let content = read_to_string(&path)?;
    let mut lines: Vec<String> = content.lines().map(|l| l.to_string()).collect();
    let mut found = false;

    for line in &mut lines {
        let trimmed = line.trim();
        if trimmed.starts_with('#') || trimmed.is_empty() {
            continue;
        }
        if let Some(pos) = trimmed.find('=') {
            let key = trimmed[..pos].trim();
            if key == option {
                *line = format!("{}={}", option, new_value);
                found = true;
                break;
            }
        }
    }

    if !found {
        lines.push(format!("{}={}", option, new_value));
    }

    let new_content = lines.join("\n");
    write(path, new_content)?;

    println!("[ConfigHandler(rs)] Guardada opción: {} = {}", option, new_value);
    Ok(())
}

fn main() -> io::Result<()> {
    let args: Vec<String> = env::args().collect();
    save_option(&args[1], &args[2])?;
    Ok(())
}