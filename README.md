## WARNING: If not careful you could configure an open relay with this.  Limit what can speak to port 25 of this container.

### Notes:
- `/var/log` is exported as a VOLUME so you can view the postfix logs
- uses `SES_USERNAME` and `SES_API_KEY` as environment variables
- see `Makefile`
