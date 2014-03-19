package com.mobilepark.did.framework.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class PageHandler {

	private int lastPage;
	private int startPage;
	private int endPage;
	
	private int prevPage;
	private int nextPage;
	
	private int curPage;
	private int totalRec;
	private int maxNum;
	private int maxPageNum;

	private int startPoint;
	private int endPoint;
	
	private List<HashMap<String, String>> numbPageUrlList = new ArrayList<HashMap<String, String>>();

	private static final int RET_MAX_NUMBER = 10;
	private static final int RET_MAX_PAGE_NUMBER = 10;
	
	public PageHandler( int curPage, int totalRec ) {
		this(curPage, totalRec, RET_MAX_NUMBER, RET_MAX_PAGE_NUMBER);
	}
	
	public PageHandler( int curPage, int totalRec, int maxNum ) {
		this(curPage, totalRec, maxNum, RET_MAX_PAGE_NUMBER);
	}

	public PageHandler( int curPage, int totalRec, int maxNum, int maxPageNum ) {
		this.curPage = curPage;
		this.totalRec = totalRec;
		this.maxNum = maxNum;
		this.maxPageNum = maxPageNum;

		this.setLastPage( totalRec, maxNum );

		this.setPageNums( curPage, maxPageNum );

		this.setRecord();
		
		this.setPageObject();
	}

	private void setLastPage( int newTotalRec, int newMaxNum ) {
		
		int tempLastPage = newTotalRec/newMaxNum;

		if ( newTotalRec % newMaxNum == 0 )
		{
			lastPage = tempLastPage;
		} else {
			lastPage = tempLastPage + 1;
		}
	}

	private void setPageNums( int newCurPage, int newMaxPageNum ) {

		int tempPage = newCurPage/newMaxPageNum;

		if ( newCurPage%newMaxPageNum == 0 ) tempPage = tempPage - 1;

		if ( newMaxPageNum > lastPage )
		{
			startPage = 1;
			endPage = lastPage;
		} else if ( newCurPage - tempPage < 1 ) {
			startPage = 1;
			endPage = newMaxPageNum;
		} else {
			startPage = tempPage * newMaxPageNum + 1;
			endPage = ( tempPage + 1 ) * newMaxPageNum;
		}

		if ( endPage > lastPage ) endPage = lastPage;
		
		prevPage = newCurPage-1;
		if(prevPage ==0){
			prevPage = 1;
		}
		nextPage = newCurPage+1;
		if(nextPage > lastPage){
			nextPage = lastPage;
		}
	}

	private void setRecord() {
		
		startPoint = (curPage-1) * maxNum;

		endPoint = maxNum;
	}

	public int getCurPage() {
		return this.curPage;
	}

	public int getStartPage() {
		return this.startPage;
	}

	public int getEndPage() {
		return this.endPage;
	}

	public int getPrevPage() {
		return this.prevPage;
	}

	public int getNextPage() {		
		return this.nextPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public int getMaxNum() {
		return maxNum;
	}

	public int getMaxPageNum() {
		return maxPageNum;
	}

	public int getPageStartRec() {
		return startPoint;
	}

	public int getPageEndRec() {
		return endPoint;
	}

	public int getTotalRec() {
		return totalRec;
	}
	
	private void setPageObject() {
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		for(int i=this.startPage; i<(this.endPage+1); i++) {
			hashMap = new HashMap<String, String>();
			
			hashMap.put("pageNumb", String.valueOf(i));

			this.numbPageUrlList.add(hashMap);
		}
	}
	
	public List<HashMap<String, String>> getNumbPageUrlList() {
		return this.numbPageUrlList;
	}
	
	public static int getCurrentPage(String curPage)
	{
		int currentPage = 1;
		
		if(!(curPage == null || curPage.equals(""))) {
			currentPage = Integer.parseInt(curPage);
		}
		
		return currentPage;
	}
	
}