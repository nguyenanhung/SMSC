package io.smsc.security;

import java.io.Serializable;

public class JWTAuthenticationResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String token;

    private final String refreshToken;

    public JWTAuthenticationResponse(String token, String refreshToken) {
        this.token = token;
        this.refreshToken = refreshToken;
    }

    public String getToken() {
        return this.token;
    }

    public String getRefreshToken() {
        return refreshToken;
    }
}
