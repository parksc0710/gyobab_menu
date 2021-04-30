package com.park.gyobab.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.park.gyobab.persistence.MemberDAO;
 
@Service
public class CustomUserDetailsService implements UserDetailsService {
 
    @Inject
    MemberDAO dao;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetails userInfo = null;
        try {
            int member_id = dao.selectMemberID(username);
            userInfo = (UserDetails) dao.selectMember(member_id); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return userInfo;
    }
    
 
}