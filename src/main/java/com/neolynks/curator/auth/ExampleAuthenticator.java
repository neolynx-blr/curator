package com.neolynks.curator.auth;

import io.dropwizard.auth.AuthenticationException;
import io.dropwizard.auth.Authenticator;
import io.dropwizard.auth.basic.BasicCredentials;
import io.dropwizard.hibernate.UnitOfWork;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neolynks.curator.core.Account;
import com.neolynks.curator.core.User;
import com.neolynks.curator.manager.AccountService;
import com.neolynks.curator.util.PasswordHash;

public class ExampleAuthenticator implements Authenticator<BasicCredentials, User> {

	static Logger LOGGER = LoggerFactory.getLogger(ExampleAuthenticator.class);

	final AccountService accountService;

	public ExampleAuthenticator(AccountService accountService) {
		super();
		this.accountService = accountService;
	}

	@Override
	@UnitOfWork
	public Optional<User> authenticate(BasicCredentials credentials) throws AuthenticationException {

		LOGGER.debug("Validating credentials for user [{}] against the DB", credentials.getUsername());
		Optional<Account> accountDetail = this.accountService.getAccountDetails(credentials.getUsername());

		if (accountDetail.isPresent()) {
			try {
				if (PasswordHash.validatePassword(credentials.getPassword(), accountDetail.get().getPasswordHash())) {
					return Optional.of(new User(accountDetail.get()));
				}
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				LOGGER.error("Received message [{}} while authenticating credentials for user [{}}", e.getMessage(),
						credentials.getUsername());
				e.printStackTrace();
			}
		}
		return Optional.empty();
	}
}
