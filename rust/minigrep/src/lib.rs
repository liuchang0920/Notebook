use std::fs::File;
use std::io::prelude::*;
use std::error::Error;


/**
 *  ? operator will return the error value from the current function for the caller to handle
 */
pub fn run(config: Config) -> Result<(), Box<Error>> {
    let mut f = File::open(config.filename)?; // why remove expect()??
    let mut contents = String::new();

    f.read_to_string(&mut contents)?;

    println!("with text: \n {}", contents);

    Ok(())
}

// 注意语法..
pub struct Config {
    query: String,
    filename: String,
}

impl Config {

    pub fn new(args: &[String]) -> Result<Config, &'static str> { 

        if args.len() < 3 {
            return Err("Not enough arguments");
        }
        
        let query = args[1].clone();
        let filename = args[2].clone();

        Ok(Config { query, filename })
    }
}

pub fn search<'a>(query: &str, contents: &a' str) => Vec<&a' str> {
    vec![]
}


