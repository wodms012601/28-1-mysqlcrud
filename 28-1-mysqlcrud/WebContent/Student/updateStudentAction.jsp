<!-- Ź����, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR�� ���ڵ�
	request.setCharacterEncoding("EUC-KR");

	int studentNo = Integer.parseInt(request.getParameter("no")); //����Ʈ ���������� �Ѱܹ��� �л� ��ȣ �����͸� ������ ����

	//�л� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	Student stu = new Student();
	stu.setStudentNo(studentNo); //�л� ��ȣ
	stu.setStudentName(request.getParameter("studentName")); //�л��̸�
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //�л�����
	System.out.println("�̸�,���� ���� �Ϸ�");
	
	//�л� ���̺� ����
	StudentDao stuDao = new StudentDao();
	stuDao.updateStudent(stu); //�л���ȣ�� �л��̸�, ���� �����Ͱ� ����� �л� ��ü�� �ּҰ��� �Ű������� ����
	
	
	//�ּҴ� �ٸ� ���̺� �����ϱ����� �л� �ּҰ�ü ����
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(studentNo); //�л� ��ȣ ������
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //�л� �ּҵ�����
	System.out.println("�ּ� ���� �Ϸ�");
	
	//�л��ּ� ���̺� ����
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.updateStudentAddr(addr); //�л� ��ȣ�����Ϳ� �л� �ּ� �����Ͱ� ����� �л� �ּҰ�ü �ּҰ��� �Ű������� ����
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //��� ó���� ������ ����Ʈ�������� �̵�
%>