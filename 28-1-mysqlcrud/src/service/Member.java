package service;

public class Member {
	
	private int member_no;
	private String member_name;
	private int member_age;
	// private는 자기 자신 클래스 내에서만 이용할 수 있는 멤버를 선언할 때 사용한다.

	
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no; 
		// this는 자기 자신을 뜻하는말로 지역변수 안과 같은 변수로 인식하면 안되기 때문에 멤버변수란걸 알려주기 위해 this를 쓴다.
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public int getMember_age() {
		return member_age;
	}
	public void setMember_age(int member_age) {
		this.member_age = member_age;
	}
}
