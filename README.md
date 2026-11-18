# Weather Dashboard

This is a Streamlit-based weather dashboard that uses the OpenWeather API.

Requirements
- Python 3.10+
- An OpenWeather API key (set as environment variable `OPENWEATHER_API_KEY`).

Quick start (PowerShell)

```powershell
# 1) Create and activate a virtual environment
python -m venv .venv
.\.venv\Scripts\Activate.ps1

# 2) Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# 3) Set your OpenWeather API key for this session
$env:OPENWEATHER_API_KEY = "YOUR_API_KEY_HERE"
# To set it permanently for your user (PowerShell - needs restart of shells):
# [Environment]::SetEnvironmentVariable('OPENWEATHER_API_KEY','YOUR_API_KEY_HERE','User')

# 4) Run the Streamlit app
streamlit run .\weather-dashboard\weather_dashboard.py
```

Notes
- The app will show an error and stop if `OPENWEATHER_API_KEY` is not set.
- The script uses the OpenWeather "Current Weather" and "One Call" endpoints. One Call may return HTTP 401 if your API key doesn't have access; the app skips the One Call forecast silently in that case.

Files
- `weather-dashboard/weather_dashboard.py`: main entrypoint (Streamlit app)
- `requirements.txt`: pinned minimal dependencies

If you want, I can also start the app here (in a background terminal) to verify it launches — tell me if you want that and provide your API key (or confirm you want me to use a placeholder).