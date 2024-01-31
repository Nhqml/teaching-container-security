import os
import json

def main():
    config = {
        "app_id": 1,
        "env": "dev"
    }
    try:
        with open("config.json", "r") as f:
            config |= json.load(f)
    except FileNotFoundError:
        pass

    if app_id := os.environ.get("APP_ID"):
        config["app_id"] = int(app_id)
    if env := os.environ.get("ENV"):
        config["env"] = env

    print(f"I'm app {config['app_id']}, running in {config['env']} mode")

if __name__ == "__main__":
    main()
