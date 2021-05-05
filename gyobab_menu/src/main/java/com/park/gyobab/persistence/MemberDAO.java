package com.park.gyobab.persistence;

import com.park.gyobab.domain.MemberVO;

public interface MemberDAO {
	
	public String getTime();
	
	public void insertMember(MemberVO vo);

	public MemberVO selectMemberById(int member_id) throws Exception;
	
	public MemberVO selectMemberByEmail(String member_email) throws Exception;
	
	public Integer selectMemberIdByEmail(String member_email) throws Exception;

}