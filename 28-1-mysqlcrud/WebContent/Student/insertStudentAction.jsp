<!-- Ź����, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR�� ���ڵ�
	request.setCharacterEncoding("EUC-KR");

	//StudentŬ������ ���� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName")); //�л��̸�
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //�л�����
	System.out.println("�̸�,���� �Է� �Ϸ�");
	
	//�л� ���̺� ����
	StudentDao stuDao = new StudentDao();
	Student student = stuDao.insertStudent(stu);
	
	
	//�ּҴ� �ٸ� ���̺� �����ϱ����� StudentAddrŬ������ ���� ��ü ����
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(student.getStudentNo());
	System.out.println(student.getStudentNo() + "<--Ȯ�ο�"); //�л� ��ȣ
	
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //�л� �ּҵ�����
	System.out.println("�ּ� �Է� �Ϸ�");
	
	//�л��ּ� ���̺� ����
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.insertStudentAddr(addr);
%>