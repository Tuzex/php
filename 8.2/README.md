### Blackfire Agent

```yaml
blackfire:
  image: blackfire/blackfire:2
  environment:
    BLACKFIRE_CLIENT_ID: ${BLACKFIRE_CLIENT_ID}
    BLACKFIRE_CLIENT_TOKEN: ${BLACKFIRE_CLIENT_TOKEN}
    BLACKFIRE_SERVER_ID: ${BLACKFIRE_SERVER_ID}
    BLACKFIRE_SERVER_TOKEN: ${BLACKFIRE_SERVER_TOKEN}
  ports:
    - 8307
```