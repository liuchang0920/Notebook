mod lib;

use std::env;
use std::process;

// use minigrep::Config;

fn main() {
    // println!("Hello, world!");
    // collect() returns the iterator
    let args: Vec<String> =  env::args().collect();

    let config = lib::Config::new(&args).unwrap_or_else(|err| {
        println!("Problem parsing arguments: {}", err);
        process::exit(1);
    });

    if let Err(e) = lib::run(config) {
        println!("Application Error: {}", e);

        process::exit(1);
    }

}
