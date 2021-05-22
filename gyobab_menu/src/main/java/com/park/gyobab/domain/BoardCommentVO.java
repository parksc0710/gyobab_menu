package com.park.gyobab.domain;

import java.io.Serializable;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("BoardCommentVO")
public class BoardCommentVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 671539172609094821L;

	private int board_comment_id;
	private int board_comment_parent;
	private String board_comment_txt;
	private BoardVO boardVO;
	private MemberVO memberVO;
	private String parent_member_name;
	private int board_comment_depth;
	private int board_comment_order;
    private Date create_date;
    private Date update_date;
    private boolean act_flg;
    private boolean del_flg;
    private boolean view_flg;
    
	public int getBoard_comment_id() {
		return board_comment_id;
	}
	public void setBoard_comment_id(int board_comment_id) {
		this.board_comment_id = board_comment_id;
	}
	public int getBoard_comment_parent() {
		return board_comment_parent;
	}
	public void setBoard_comment_parent(int board_comment_parent) {
		this.board_comment_parent = board_comment_parent;
	}
	public BoardVO getBoardVO() {
		return boardVO;
	}
	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public String getParent_member_name() {
		return parent_member_name;
	}
	public void setParent_member_name(String parent_member_name) {
		this.parent_member_name = parent_member_name;
	}
	public int getBoard_comment_depth() {
		return board_comment_depth;
	}
	public void setBoard_comment_depth(int board_comment_depth) {
		this.board_comment_depth = board_comment_depth;
	}
	public int getBoard_comment_order() {
		return board_comment_order;
	}
	public void setBoard_comment_order(int board_comment_order) {
		this.board_comment_order = board_comment_order;
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
	public String getBoard_comment_txt() {
		return board_comment_txt;
	}
	public void setBoard_comment_txt(String board_comment_txt) {
		this.board_comment_txt = board_comment_txt;
	}
	public boolean isView_flg() {
		return view_flg;
	}
	public void setView_flg(boolean view_flg) {
		this.view_flg = view_flg;
	}
}
