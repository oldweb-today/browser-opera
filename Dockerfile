FROM webrecorder/base-browser

 RUN apt-get update && apt-get install -y \
     libcurl4-openssl-dev libxcomposite1 libxcursor1 libxi6 \
     libgconf2-4 libatk1.0 libcups2 libnotify4 libgtk2.0-0 \
#     libgtk-3-0 libasound2 libdbus-glib-1-2 libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /download

ENV OPERA_VERSION 38.0.2220.44

RUN wget http://arc.opera.com/pub/opera/source/desktop/opera_stable-38.0.2220.44-linux-release-x64.tar.xz && \
    tar xvf opera_stable-$OPERA_VERSION-linux-release-x64.tar.xz

RUN ls

RUN sudo mv ./opera_stable-$OPERA_VERSION-linux-release-x64 /opt/opera

RUN sudo chmod 4755 /opt/opera/opera_sandbox

RUN sudo ls -l /opt/opera

# ADD flash.list /etc/apt/sources.list.d/flash.list

ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

#RUN apt-get -y update && \
#    apt-get -qqy install software-properties-common \
#    adobe-flashplugin && \
#    add-apt-repository ppa:webupd8team/java && \
#    apt-get update && \
#    apt-get -qqy install oracle-java6-installer && \
#    rm -rf /var/lib/apt/lists/*

USER browser
WORKDIR /home/browser

# COPY ./operaprofile/. /home/browser/operaprofile/

COPY run.sh /app/run.sh

# Maybe just an environment variable that needs to be set?
# COPY proxy.js /home/browser/proxy.js

RUN sudo chmod a+x /app/run.sh

CMD /app/entry_point.sh /app/run.sh

LABEL wr.name="Opera" \
      wr.version="49" \
      wr.os="linux" \
      wr.release="2016-09-23" \
      wr.about="https://en.wikipedia.org/wiki/Opera_(web_browser)" \
      wr.caps.flash="1" \
      wr.caps.java="1" \
      wr.icon="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADeUlEQVR4AU1TU2DEaBicP8m6tm3zbNu2ns62bdu27att2263q2yTTbL5rtvjw3yambdvQG+dDPlCsNeuu4w/9skuLrB/PrIWd1eD/fTra5y3XV/juO2WetcpLw/I0QHura5ZVvP81XxgDmCn/P7hLdwOOaWHXPHlzGPHfbzuPOmLDbrou1X9ou/X9LO+XKYLPp/bfL1z4/5vRbIFtD19d+14WKBsDNdV9hv33P+eyEdO9Lhcu+XEj1BUhImmsTcZORV2n8ppdhG7hijshFxxRf359Sv3TfZ+9Pt+93ECAIwP2w7SrYsPni/eogVHi/70sHXuQufTnF0ghJIXXlmFZd1JQ8ua/+xqW2zkQZUf9vR9IB1Qc8vXHACYrMaUlKBNHIAW2sfSzytTGtt/8BvssfAZ3GsizHY3jKrG5hadfO848ydVhCHj0NArAYDN3ZoX71ujbo1YLFl5MsQxpqk+WMR0vGM6GB95q2DeckL3erElA6nBa/TdoxpjqFmTl78vFnwO7KWIiIWRSND9jNwcIhM13O3aCz/OFSGSLUIWJSieze2+hbLDspjPN0zwFcV0vdZyIud1Ilz1AdBAqsxgH1Bx07d74rt+K9TFCcxMOeFcnAe5V+BZmEduUjesMTP6zKKIXk9ymiBL0JiPQeAJikqwmYDdw1fQOzuP+HAfqjMcqBkKx+SUB0ZNRpBzDHA4WLCqYI982xirOzIvyy+jK9hCwWYbiBkZM1s0+HgBAvkxLgt4eyUbP3XZUJG9hM/uXiGESUwbFDapy1LB7X1K8YS8Re0ekUGVoZNKEEUB33ZbcdHnCTjx42x82wrYNDtOrXKCc2u0XmNDz4/WuejyglkOADQFj4segltk8G2BDDrhoGwJJ1Z6cXbRKq4oWcKHpyzh6HgFG41GfapVwOA41wwAwvePDHBHXVfy3fsP9DwHnb+E/EzTNHBWs86OiXSx4+MBZmDk34Z3CrrsZoLZrdTtEaPcCOCvLPQdVsQARN6VlPzFx4U59MtueXr9AfnUcngedRyVR93HBpDv/2r/AnqqOP1XAFEB3/mp0QyBYb+wEFZos1qB7QcLDrvlwZSUntdyM10flWZrn1RmKx9VZTleL88cPTsp5VkBXF5GhNF8a2ES908a/8XPZUUcz8ADiAsDv+v+1pCjq0xBh1vAVwOIB3bCx/7v+RODWtK1Q31ZvwAAAABJRU5ErkJggg=="
