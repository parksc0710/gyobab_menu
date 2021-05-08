<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="card-header">
        <h3><b>회원 관리 페이지</b></h3>
    </div>
    <div class="col-12">
       <div class="card mb-3">
           <div class="card-header">
               <h3><i class="fas fa-user-friends"></i>회원 정보</h3>
           </div>

           <div class="card-body">

				<div class="table-responsive">
					<div id="dataTable_wrapper"
						class="dataTables_wrapper dt-bootstrap4 no-footer">
						<div class="row">
							<div class="col-sm-12">
								<table id="dataTable"
									class="table table-bordered table-hover display dataTable no-footer"
									style="width: 100%;" role="grid"
									aria-describedby="dataTable_info">
									<thead>
										<tr role="row">
											<th class="sorting_asc" style="width: 30px;">권한</th>
											<th class="sorting_asc" style="width: 60px;">이메일</th>
											<th class="sorting_asc" style="width: 60px;">닉네임</th>
											<th class="sorting_asc" style="width: 60px;">회원가입일</th>
											<th class="sorting_asc" style="width: 30px;">수정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${list}">
											<tr role="row" class="odd">
												<td class="sorting_1">${list.member_grant}</td>
												<td class="sorting_1">${list.member_email}</td>
												<td class="sorting_1">${list.member_name}</td>
												<td class="sorting_1"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.create_date}" /></td>
												<td class="sorting_1">${list.member_id}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-5">
								<div class="dataTables_info" id="dataTable_info" role="status"
									aria-live="polite"></div>
							</div>
							<div class="col-sm-12 col-md-7">
								<!-- <div class="dataTables_paginate paging_simple_numbers"
									id="dataTable_paginate">
									<ul class="pagination">
										<li class="paginate_button page-item previous disabled"
											id="dataTable_previous"><a href="#"
											aria-controls="dataTable" data-dt-idx="0" tabindex="0"
											class="page-link">Previous</a></li>
										<li class="paginate_button page-item active"><a href="#"
											aria-controls="dataTable" data-dt-idx="1" tabindex="0"
											class="page-link">1</a></li>
										<li class="paginate_button page-item "><a href="#"
											aria-controls="dataTable" data-dt-idx="2" tabindex="0"
											class="page-link">2</a></li>
										<li class="paginate_button page-item "><a href="#"
											aria-controls="dataTable" data-dt-idx="3" tabindex="0"
											class="page-link">3</a></li>
										<li class="paginate_button page-item "><a href="#"
											aria-controls="dataTable" data-dt-idx="4" tabindex="0"
											class="page-link">4</a></li>
										<li class="paginate_button page-item next" id="dataTable_next"><a
											href="#" aria-controls="dataTable" data-dt-idx="5"
											tabindex="0" class="page-link">Next</a></li>
									</ul>
								</div> -->
							</div>
						</div>
					</div>
				</div>
				<!-- end table-responsive-->

			</div>
           <!-- end card-body-->
       </div>
       <!-- end card-->
   </div>
</div>