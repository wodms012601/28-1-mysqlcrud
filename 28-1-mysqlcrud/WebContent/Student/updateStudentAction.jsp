<!-- Ź����, 2018.07.03 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR�� ���ڵ�
	request.setCharacterEncoding("EUC-KR");

	int studentNo = Integer.parseInt(request.getParameter("no"));

	//StudentŬ������ ���� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	Student stu = new Student();
	stu.setStudentNo(studentNo); //�л� �ѹ�
	stu.setStudentName(request.getParameter("studentName")); //�л��̸�
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //�л�����
	System.out.println("�̸�,���� ���� �Ϸ�");
	
	//�л� ���̺� ����
	StudentDao stuDao = new StudentDao();
	stuDao.updateStudent(stu);
	
	
	//�ּҴ� �ٸ� ���̺� �����ϱ����� StudentAddrŬ������ ���� ��ü ����
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(studentNo); //�л� �ѹ�
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //�л� �ּҵ�����
	System.out.println("�ּ� ���� �Ϸ�");
	
	//�л��ּ� ���̺� ����
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.updateStudentAddr(addr);
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //��� ó���� ������ ����Ʈ�������� �̵�
%>