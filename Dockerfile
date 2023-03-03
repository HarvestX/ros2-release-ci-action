FROM alphine:3.10

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entryopint.sh"]
