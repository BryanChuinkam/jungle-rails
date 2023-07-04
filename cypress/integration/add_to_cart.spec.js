describe('home page', () => { 

  it('can visit the homepage', () => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('lets you add a product to the cart ensures that cart increases by 1', () => {
    cy.contains('My Cart (0)')
    
    cy.contains('Add').first().click({force: true})

    cy.contains('My Cart (1)')
  })


});