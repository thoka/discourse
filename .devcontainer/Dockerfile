FROM discourse/discourse_dev:20260109-0020

# Wir wechseln frühzeitig zum discourse user
USER discourse
WORKDIR /workspace/discourse

# Pfade für Gems und Binstubs (User-spezifisch)
ENV PATH="/workspace/discourse/vendor/bundle/ruby/3.3.0/bin:/workspace/discourse/bin:${PATH}"

# Wir kopieren die Gemfiles als discourse user
# Docker sorgt bei COPY automatisch dafür, dass die Dateien dem aktuellen USER gehören
COPY --chown=discourse:discourse Gemfile Gemfile.lock ./

# Jetzt installieren wir direkt als discourse user
# Da uns der WORKDIR gehört, brauchen wir kein sudo oder root
RUN bundle config set --local path 'vendor/bundle' && \
    bundle install --jobs 4 && \
    gem install ruby-lsp

