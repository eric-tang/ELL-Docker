from erict2017/rpi0-ell-base:v1.0

# copy entry point script
COPY ./entrypoint.sh /home/sources/

RUN ["chmod", "+x", "/home/sources/entrypoint.sh"]

# Start building process
ENTRYPOINT ["/home/sources/entrypoint.sh"]
