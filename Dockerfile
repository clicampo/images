ARG ALPINE_VERSION=3.20

FROM ghcr.io/runatlantis/atlantis:v0.28.5

LABEL org.opencontainers.image.source=https://github.com/clicampo/docker-atlantis-terragrunt

ENV TERRAGRUNT_VERSION=v0.66.8 \
  VAULT_VERSION=1.10.1 \
  TERRAGRUNT_ATLANTIS_CONFIG_VERSION=1.18.0 \
  TERRAFORM_VERSION=1.9.4 \
  DEFAULT_TERRAFORM_VERSION=1.9.4 \
  AWS_CLI_VERSION=2.15.57-r0

# AWS CLI v2
USER root
RUN apk add --no-cache aws-cli==${AWS_CLI_VERSION}


SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -Ls https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 --output /usr/local/bin/terragrunt \
  && chmod +x /usr/local/bin/terragrunt \
  && curl -LOs https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/local/bin \
  && rm vault_${VAULT_VERSION}_linux_amd64.zip \
  && curl -Ls https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_amd64 --output /usr/local/bin/terragrunt-atlantis-config \
  && chmod +x /usr/local/bin/terragrunt-atlantis-config

USER atlantis
