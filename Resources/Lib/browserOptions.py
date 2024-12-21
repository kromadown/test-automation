import os
import configparser
from pathlib import Path
from msedge.selenium_tools import EdgeOptions
from selenium.webdriver import ChromeOptions


class browserOptions:
    def __init__(self, config_path='../../POM/POM_Variables.yaml'):
        with open(config_path, 'r') as f:
            config_string = '[global]\n' + f.read()

        config = configparser.ConfigParser()
        config.read_string(config_string)
        self.config = config
        self.headless = self.config['global']['Headless'] == 'True'
        self.browser = self.config['global']['Browser'].replace('\'', '')
        self.options = {}

    def get_options(self, download_path=r'.\Downloads'):
        os.makedirs(download_path, exist_ok=True)
        full_download_path = os.path.dirname(os.path.realpath(download_path)) + os.path.sep + Path(download_path).name
        print(self.browser)
        if self.browser == 'edge':
            self.set_edge_options(full_download_path)
        elif self.browser == 'chrome':
            self.set_chrome_options(full_download_path)

        return self.options

    def set_chrome_options(self, download_path):
        prefs = {
            'download.default_directory': download_path
        }

        self.options = ChromeOptions()
        if self.headless:
            self.options.headless = True

        self.options.add_experimental_option("prefs", prefs)
        self.options.add_argument("--log-level=2")

    def set_edge_options(self, download_path):
        prefs = {
            'download.default_directory': download_path,
            'download.prompt_for_download': False,
            'download.directory_upgrade': True,
            'safebrowsing.enabled': False,
            'safebrowsing.disable_download_protection': True
        }

        self.options = EdgeOptions()
        self.options.use_chromium = True
        if self.headless:
            self.options.add_argument("headless")
            self.options.add_argument("disable-gpu")

        self.options.add_experimental_option("prefs", prefs)
