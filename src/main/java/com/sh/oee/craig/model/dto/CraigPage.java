package com.sh.oee.craig.model.dto;

public class CraigPage {
	
	//최소 페이지 번호
	private int min;
	//최대 페이지 번호 
	private int max;
	//이전 버톤의 페이지 번호
	private int prevPage;
    //다음 버튼의 페이지 번호 
	private int nextPage;
	//전체 페이지 
	private int pageCnt;
	//현재 페이지 번호
	private int currentPage;
	
	//get()메서드 
	public int getMin() {
		return min;
	}
	public int getMax() {
		return max;
	}
	
	public int getPrevPage() {
		return prevPage;
	}
	
	public int getNextPage() {
		return nextPage;
	}
	
	public int getPageCnt() {
		return pageCnt;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	//생성자에서 계산으로설정 
	
	//contentCnt : 전체글 개수, currentPage:현재글번호, <-- 현재페이지번호겟지?
	//contentPageCnt : 페이지당 글의 개수, paginationCnt: 페이지 버튼의 개수 
	
	public CraigPage(int contentCnt, int currentPage, int contentPageCnt, int paginationCnt) {
		
		//현재페이지번호
		this.currentPage = currentPage;
		//전체페이지 개수
		pageCnt = contentCnt / contentPageCnt;
		if(contentCnt % contentPageCnt > 0) {
			pageCnt++;
		}
		
		//페이지네이션 최소값, 최대값
		min = ((currentPage - 1)/ paginationCnt) * paginationCnt + 1;
		max = min + paginationCnt - 1;
		//최대값이 실제 최대페이지 보다 크면 최대페이지로 설정
		if(max > pageCnt) {
			max = pageCnt;
		}
		
		//이전페이지값, 다음페이지값
		prevPage = min-1;
		nextPage = max+1;
		//다음페이지가 최대페이지보다 크면 최대페이지로 설정
		if(nextPage > pageCnt) {
			nextPage = pageCnt;
		}
	}

}
