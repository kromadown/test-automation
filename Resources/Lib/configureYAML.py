from pyaml_env import parse_config
import os


def get_configuration_from_yaml(variable):
    cpath = os.getcwd()
    base_path = os.path.abspath(os.path.join(cpath, '..//..'))
    full_base_path = base_path + r'/POM/POM_Credentials.yaml'
    config = parse_config(full_base_path)
    print(config)
    return config[variable]
