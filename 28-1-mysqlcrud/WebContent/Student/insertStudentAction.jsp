<!-- Ź����, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR�� ���ڵ�
	request.setCharacterEncoding("EUC-KR");

	//�л� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName")); //�л��̸�
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //�л�����
	System.out.println("�̸�,���� �Է� �Ϸ�");
	
	//�л� ���̺� ����
	StudentDao stuDao = new StudentDao();
	/*�л��̸��� ���� �����Ͱ� ����� �л� ��ü�� �ּҰ��� �Ű������� ����
	 �л��ѹ������Ͱ� ����� �л� ��ü�� �ּҰ��� ���Ϲ޾Ƽ� ��ü���������� ����*/
	Student student = stuDao.insertStudent(stu);
	
	
	//�ּҴ� �ٸ� ���̺� �����ϱ����� �л� �ּҰ�ü ����
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(student.getStudentNo()); //�л� ��ü�� �л� ��ȣ ������
	System.out.println(student.getStudentNo() + "<--Ȯ�ο�");
	
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //�л� �ּ�
	System.out.println("�ּ� �Է� �Ϸ�");
	
	//�л��ּ� ���̺� ����
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.insertStudentAddr(addr); //�л� ��ȣ�����Ϳ� �л� �ּ� �����Ͱ� ����� �л� �ּҰ�ü �ּҰ��� �Ű������� ����
	
	response.sendRedirect(request.getContextPath() + "/Student/studentList.jsp"); //��� ó���� ������ ����Ʈ�������� �̵�
%>