package com.baroque.api.config;

/**
 * @author elric.wang
 */
public enum Env {

    DEV("dev"),
    SAE("sae");

    public final String value;

    private Env(String value) {
        this.value = value;
    }

    public static Env parseString(String str) {
        for (Env env : Env.values()) {
            if (env.value.equalsIgnoreCase(str)) {
                return env;
            }
        }
        return null;
    }
}
