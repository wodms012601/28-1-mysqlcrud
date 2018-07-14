//07.10 송원민 Member_addr 리스트 처리
package service;

public class MemberAddr {
	private int memberAddrNo;
	private String memberAddrContent;
	private int memberNo;
	
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
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getMemberAddrNo() {
		return memberAddrNo;
	}
	public void setMemberAddrNo(int memberAddrNo) {
		this.memberAddrNo = memberAddrNo;
	}
	public String getMemberAddrContent() {
		return memberAddrContent;
	}
	public void setMemberAddrContent(String memberAddrContent) {
		this.memberAddrContent = memberAddrContent;
	}
	
	
}
