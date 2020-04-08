package www.cwb.com.framework.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import www.cwb.com.security.domain.CustomUser;

@Component("securityUtil")
public final class SecurityUtil {

    public static boolean isAnonymous() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return false;
        }
        return AnonymousAuthenticationToken.class.isAssignableFrom(authentication.getClass());
    }

    public static boolean isAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return false;
        }
        return !isAnonymous();
    }
    
    public static boolean isManager() {
    	if(!isAuthenticated()) {
    		return false;
    	}
    	
    	CustomUser currentMember = getCurrentMember();
    	return true;
    }

    /**
     * Get the login of the current user.
     *
     * @return the login of the current user
     */
    private static UserDetails getCurrentUser() {
        if (isAuthenticated()) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null) {
                return null;
            }
            return (UserDetails) authentication.getPrincipal();
        }
        return null;
    }

    /**
     * Get the login of the current member (user).
     *
     * @return the login of the current member
     */
    public static CustomUser getCurrentMember() {
        UserDetails userDetails = getCurrentUser();
        CustomUser member = null;
        if(userDetails != null && userDetails instanceof CustomUser) {
            member = (CustomUser) userDetails;
        }
        return member;
    }

    /**
     * Programmatically signs in the user with the given the user ID.
     */
    public static void signin(UserDetails detail, HttpServletRequest request) {
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(detail, null, detail.getAuthorities());
        token.setDetails(new WebAuthenticationDetails(request));

        SecurityContextHolder.getContext().setAuthentication(token);
    }

    /**
     * Signout
     */
    public static void signout() {
        SecurityContextHolder.getContext().setAuthentication(null);
    }

}
