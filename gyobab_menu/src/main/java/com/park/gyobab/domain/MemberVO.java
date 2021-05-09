package com.park.gyobab.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Alias("MemberVO")
public class MemberVO implements UserDetails, Serializable{
	 
    /**
	 * 
	 */
	private static final long serialVersionUID = 5568707156178057112L;
	
	private int member_id;
    private String member_email;
    private String member_name;
    private GrantVO grantVO;
    private String member_pass;
    private Date create_date;
    private Date update_date;
    private boolean act_flg;
    private boolean del_flg;
    
    public int getMember_id() {
		return member_id;
	}
	public GrantVO getGrantVO() {
		return grantVO;
	}
	public void setGrantVO(GrantVO grantVO) {
		this.grantVO = grantVO;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_pass() {
		return member_pass;
	}
	public void setMember_pass(String member_pass) {
		this.member_pass = member_pass;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public boolean isAct_flg() {
		return act_flg;
	}
	public void setAct_flg(boolean act_flg) {
		this.act_flg = act_flg;
	}
	public boolean isDel_flg() {
		return del_flg;
	}
	public void setDel_flg(boolean del_flg) {
		this.del_flg = del_flg;
	}
	
	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        
        String roleGrant = "ROLE_" + grantVO.getGrant_name();
        
        GrantedAuthority myGrant = new SimpleGrantedAuthority(roleGrant);
        
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        
        authorities.add(myGrant);
        
        return authorities;
    }
    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return null;
    }
    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return member_email;
    }
    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return false;
    }
    
}