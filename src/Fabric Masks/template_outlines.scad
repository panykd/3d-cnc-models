//import("template-adult.svg");

depth=50;
length=100;
width = 10;
radius = 3;

handleXOffset = 100;
handleYOffset = 13;
handleAngleOffset = 130;

textXOffset = 30;
textYOffset = 40;

model = 0;

templates = [
    ["template-small-youth.svg","Small Youth"],
    ["template-youth.svg","Youth"],
    ["template-small-adult.svg","Small Adult"],
    ["template-adult.svg","Adult"]
];



linear_extrude(height=3)
difference() {
    
    import(templates[model][0]);
    
    offset(-5)
    {
        import(templates[model][0]);
    }
}