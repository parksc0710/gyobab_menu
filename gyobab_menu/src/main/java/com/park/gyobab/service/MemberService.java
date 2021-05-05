package com.park.gyobab.service;

import com.park.gyobab.domain.MemberVO;

public interface MemberService {
	
	public void insertMember(MemberVO vo);
	
	public void insertMemberGrantUser(MemberVO vo);

	public MemberVO selectMemberById(int member_id) throws Exception;
	
	public MemberVO selectMemberByEmail(String member_email) throws Exception;
	
	public Integer selectMemberIdByEmail(String member_email) throws Exception;
	
	public Integer selectMemberIdByName(String member_name) throws Exception;
	
}
