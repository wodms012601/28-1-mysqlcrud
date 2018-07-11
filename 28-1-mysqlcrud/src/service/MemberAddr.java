//07.10 송원민 Member_addr 리스트 처리
package service;

public class MemberAddr {
	private int member_addr_no;
	private String member_addr_content;
	private int member_no;
	
	private Member member; 
	private MemberAddr memberaddr;
	// 데이터 베이스 안의 member테이블과 member_addr테이블을 join 해주기 위해서 "Getters and Setters" 하였음.
	
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public MemberAddr getMemberaddr() {
		return memberaddr;
	}
	public void setMemberaddr(MemberAddr memberaddr) {
		this.memberaddr = memberaddr;
	}
	
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getMember_addr_no() {
		return member_addr_no;
	}
	public void setMember_addr_no(int member_addr_no) {
		this.member_addr_no = member_addr_no;
	}
	public String getMember_addr_content() {
		return member_addr_content;
	}
	public void setMember_addr_content(String member_addr_content) {
		this.member_addr_content = member_addr_content;
	}
	
	
}
