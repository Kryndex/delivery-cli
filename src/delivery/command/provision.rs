use command::run_chef_exec_command;

pub fn run(args: &Vec<&str>) -> i32 {
    if !args.is_empty() {
        match args[0].as_ref() {
            // kitchen subcommands don't respond to --help, so let's return something useful.
            "--help" => {
                // Stolen from kitchen --help
                println!("USAGE:\n    delivery local provision [INSTANCE|REGEXP|all] # Change instance state to create. Start one or more instances");
                return 0
            },
            _ => return run_chef_exec_command("kitchen create", args)
        }
    } else {
        return run_chef_exec_command("kitchen create", args)
    }
}
