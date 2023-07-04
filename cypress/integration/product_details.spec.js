describe('product details page', () => {

  it('can visit the homepage', () => {
    cy.visit('/')
  })

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('You can visit the selected product detail page', () => {
    cy.visit('/')
    cy.get(".products article").first().click()
    cy.url().should("include", "/products/2")
  
  })

});