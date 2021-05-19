package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.domain.BoardLikeVO;
import com.park.gyobab.persistence.BoardLikeDAO;

@Service
public class BoardLikeServiceImpl implements BoardLikeService {

	@Inject
	private BoardLikeDAO dao;

	@Override
	public void insertBoardLike(HashMap<String, Integer> map) {
		dao.insertBoardLike(map);		
	}

	@Override
	public void deleteBoardLike(int board_like_id) {
		dao.deleteBoardLike(board_like_id);
	}

	@Override
	public List<BoardLikeVO> selectBoardLikes(int board_id) throws Exception {
		List<BoardLikeVO> list = dao.selectBoardLikes(board_id);
		return list;
	}

	@Override
	public Integer selectBoardLikeCnt(int board_id) throws Exception {
		int cnt = dao.selectBoardLikeCnt(board_id); 
		return cnt;
	}
	
}
