package com.park.gyobab.domain;

import java.io.Serializable;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("BoardVO")
public class BoardVO implements Serializable{
   
	/**
	 * 
	 */
	private static final long serialVersionUID = -4868332444078444318L;
	
	private int board_id;
	private String board_type;
    private String board_tit;
    private String board_txt;
    private MemberVO memberVO;
    private String board_thumb;
    private int board_view;
    private Date create_date;
    private Date update_date;
    private boolean act_flg;
    private boolean del_flg;
    
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getBoard_tit() {
		return board_tit;
	}
	public void setBoard_tit(String board_tit) {
		this.board_tit = board_tit;
	}
	public String getBoard_txt() {
		return board_txt;
	}
	public void setBoard_txt(String board_txt) {
		this.board_txt = board_txt;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public String getBoard_thumb() {
		return board_thumb;
	}
	public void setBoard_thumb(String board_thumb) {
		this.board_thumb = board_thumb;
	}
	public int getBoard_view() {
		return board_view;
	}
	public void setBoard_view(int board_view) {
		this.board_view = board_view;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
}
