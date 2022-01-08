# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

FROM debian:bullseye-slim

ENV domain localhost
ENV LC_CTYPE C.UTF-8

RUN apt update && apt install -y fonts-open-sans apt-transport-https gnupg2 ca-certificates openssh-client curl inotify-tools psmisc && \
    echo "deb [signed-by=/usr/share/keyrings/collaboraonline-release-keyring.gpg] https://collaboraoffice.com/repos/CollaboraOnline/CODE-debian11 /" > /etc/apt/sources.list.d/collabora.list && \
	curl https://www.collaboraoffice.com/downloads/gpg/collaboraonline-release-keyring.gpg --output /usr/share/keyrings/collaboraonline-release-keyring.gpg && \
	apt update && apt install -y coolwsd code-brand collaboraofficebasis-en-gb collaboraofficebasis-en-us collaboraoffice-dict-en collaboraofficebasis-de collaboraoffice-dict-de && \
    apt clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /etc/coolwsd/proof_key* && \
	chown cool:cool /opt/cool/systemplate/etc/hosts /opt/cool/systemplate/etc/resolv.conf && \
	chown cool:cool /etc/coolwsd

COPY /entrypoint.sh /

RUN chmod 777 /entrypoint.sh

EXPOSE 9980

USER cool

ENTRYPOINT ["/entrypoint.sh"]
