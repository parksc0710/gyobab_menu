package com.park.gyobab.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.domain.BoardVO;
import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;

	@Override
	public void insertBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}

	@Override
	public void deleteBoard(int board_id) {
		dao.deleteBoard(board_id);
	}

	@Override
	public BoardVO selectBoardById(int board_id) throws Exception {
		BoardVO tmpVo = dao.selectBoardById(board_id); 
		return tmpVo;
	}
	
	@Override
	public BoardVO selectTop1Board(String board_type) throws Exception {
		BoardVO tmpVo = dao.selectTop1Board(board_type); 
		return tmpVo;
	}

	@Override
	public List<BoardVO> selectBoards(String board_type) throws Exception {
		List<BoardVO> list = dao.selectBoards(board_type);
		return list;
	}

	@Override
	public void updateBoard(BoardVO vo) {
		dao.updateBoard(vo);
	}
	
}
