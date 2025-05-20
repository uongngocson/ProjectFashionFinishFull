package local.example.demo.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomerService;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    private AccountService accountService;
    @Autowired
    private CustomerService customerService;

    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_CUSTOMER", "");
        roleTargetUrlMap.put("ROLE_EMPLOYEE", "/admin/dashboard/index");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin/dashboard/index");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        Account account = accountService.getAccountByLoginName(authentication.getName());
        Customer customer = customerService.getCustomerByAccount(account);
        session.setAttribute("customerId", customer.getCustomerId());
        session.setAttribute("fullName", customer.getFirstName() + " " + customer.getLastName());
        session.setAttribute("email", customer.getEmail());
        session.setAttribute("avatar", customer.getImageUrl());
        session.setAttribute("sum", customerService.getCartDetailCountByCart(customer));

        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) {
            return;
        }

        // Add login success parameter for all roles
        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if ("ROLE_CUSTOMER".equals(authorityName)) {
                if (targetUrl.isEmpty()) {
                    targetUrl = "/?login=success";
                } else {
                    targetUrl = targetUrl + "?login=success";
                }
                break;
            } else if ("ROLE_ADMIN".equals(authorityName) || "ROLE_EMPLOYEE".equals(authorityName)) {
                // Add login=success parameter to admin URLs
                if (targetUrl.contains("?")) {
                    targetUrl = targetUrl + "&login=success";
                } else {
                    targetUrl = targetUrl + "?login=success";
                }
                break;
            }
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request, authentication);
    }

}
