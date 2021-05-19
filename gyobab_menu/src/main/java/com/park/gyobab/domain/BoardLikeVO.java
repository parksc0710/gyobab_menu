package com.park.gyobab.domain;

import java.io.Serializable;
import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("BoardLikeVO")
public class BoardLikeVO implements Serializable{
   
	/**
	 * 
	 */
	private static final long serialVersionUID = -840070313089822470L;
		
	private int board_like_id;
	private MemberVO memberVO;
	private BoardVO boardVO;
    private Date create_date;
    
	public int getBoard_like_id() {
		return board_like_id;
	}
	public void setBoard_like_id(int board_like_id) {
		this.board_like_id = board_like_id;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public BoardVO getBoardVO() {
		return boardVO;
	}
	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
    
}
