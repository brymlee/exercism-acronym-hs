FROM docker.io/haskell:8.8.4
RUN mkdir acronym
WORKDIR acronym
COPY package.yaml package.yaml
COPY stack.yaml stack.yaml
COPY src src
COPY test test
RUN ghc src/Acronym.hs 
RUN /usr/local/bin/stack test
CMD ["/usr/local/bin/stack", "test"]
