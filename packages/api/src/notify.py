import requests

# Function to verify if the target is reachable

def verify_target_reachability(url):
    try:
        response = requests.get(url)
        return response.status_code == 200
    except requests.exceptions.RequestException as e:
        print(f"Error reaching the target: {e}")
        return False

# Example usage
if __name__ == '__main__':
    target_url = 'http://example.com/api'
    if verify_target_reachability(target_url):
        print('Target is reachable')
    else:
        print('Target is not reachable')