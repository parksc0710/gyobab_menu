package com.park.gyobab.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("GrantVO")
public class GrantVO {
    private int grant_id;
    private String grant_name;
    private Date create_date;
    private Date update_date;
    private int update_member;
    private boolean act_flg;
    private boolean del_flg;
	public int getGrant_id() {
		return grant_id;
	}
	public void setGrant_id(int grant_id) {
		this.grant_id = grant_id;
	}
	public String getGrant_name() {
		return grant_name;
	}
	public void setGrant_name(String grant_name) {
		this.grant_name = grant_name;
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
	public int getUpdate_member() {
		return update_member;
	}
	public void setUpdate_member(int update_member) {
		this.update_member = update_member;
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
    
}
