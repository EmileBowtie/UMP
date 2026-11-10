-- UMP Formula Data
-- Ported from the current web version. Formula strings use Unicode notation because Roblox TextLabels do not render KaTeX.
local Data = {}

Data.TimeLimit = 30
Data.ReviewIntervals = {1, 3, 7, 14, 30}

Data.Topics = {
 {id="sqrt", name="Square roots", ru="Квадратные корни", overview={
  "√(ab) = √a · √b  (a,b ≥ 0)","√(a/b) = √a / √b  (b > 0)","√(a²) = |a|","(√a)² = a  (a ≥ 0)"
 }, formulas={
  {"What is √(ab) equal to?","Чему равно √(ab)?",{"√a · √b","√a + √b","a√b"},{"√a · √b","√a + √b","a√b"},"Product rule for radicals.","Правило произведения корней."},
  {"What is √(a/b) equal to?","Чему равно √(a/b)?",{"√a / √b","a / √b","√(a − b)"},{"√a / √b","a / √b","√(a − b)"},"Quotient rule for radicals.","Правило частного корней."},
  {"What is √(a²)?","Чему равно √(a²)?",{"|a|","a","a²"},{"|a|","a","a²"},"The principal square root is non-negative, so the result is |a|.","Арифметический квадратный корень неотрицателен, поэтому результат равен |a|."},
  {"What is (√a)² (a ≥ 0)?","Чему равно (√a)² (a ≥ 0)?",{"a","√a","a²"},{"a","√a","a²"},"Squaring undoes the square root.","Возведение в квадрат отменяет извлечение корня."}
 }},
 {id="pow", name="Powers", ru="Степени", overview={
  "aᵐ · aⁿ = aᵐ⁺ⁿ","aᵐ / aⁿ = aᵐ⁻ⁿ","(aᵐ)ⁿ = aᵐⁿ","a⁰ = 1  (a ≠ 0)","a⁻ⁿ = 1/aⁿ","(ab)ⁿ = aⁿbⁿ"
 }, formulas={
  {"What is aᵐ · aⁿ?","Чему равно aᵐ · aⁿ?",{"aᵐ⁺ⁿ","aᵐⁿ","aᵐ⁻ⁿ"},{"aᵐ⁺ⁿ","aᵐⁿ","aᵐ⁻ⁿ"},"Same base: add exponents.","Одинаковое основание: складываем показатели."},
  {"What is aᵐ / aⁿ?","Чему равно aᵐ / aⁿ?",{"aᵐ⁻ⁿ","aᵐ⁺ⁿ","aᵐ⁄ⁿ"},{"aᵐ⁻ⁿ","aᵐ⁺ⁿ","aᵐ⁄ⁿ"},"Same base: subtract exponents.","Одинаковое основание: вычитаем показатели."},
  {"What is (aᵐ)ⁿ?","Чему равно (aᵐ)ⁿ?",{"aᵐⁿ","aᵐ⁺ⁿ","aᵐⁿ (nested)"},{"aᵐⁿ","aᵐ⁺ⁿ","aᵐⁿ (влож.)"},"Power of a power: multiply exponents.","Степень степени: умножаем показатели."},
  {"What is a⁰ (a ≠ 0)?","Чему равно a⁰ (a ≠ 0)?",{"1","0","a"},{"1","0","a"},"Any non-zero number to power zero is 1.","Любое ненулевое число в нулевой степени равно 1."},
  {"What is a⁻ⁿ?","Чему равно a⁻ⁿ?",{"1/aⁿ","−aⁿ","a¹⁄ⁿ"},{"1/aⁿ","−aⁿ","a¹⁄ⁿ"},"A negative exponent means reciprocal.","Отрицательная степень означает обратное число."},
  {"What is (ab)ⁿ?","Чему равно (ab)ⁿ?",{"aⁿbⁿ","aⁿ + bⁿ","abⁿ"},{"aⁿbⁿ","aⁿ + bⁿ","abⁿ"},"The power distributes over the product.","Степень распределяется на множители."}
 }},
 {id="binom", name="Short multiplication", ru="Формулы сокращённого умножения", overview={
  "(a+b)² = a² + 2ab + b²","(a−b)² = a² − 2ab + b²","a² − b² = (a−b)(a+b)","(a+b)³ = a³ + 3a²b + 3ab² + b³","(a−b)³ = a³ − 3a²b + 3ab² − b³","a³ + b³ = (a+b)(a²−ab+b²)","a³ − b³ = (a−b)(a²+ab+b²)"
 }, formulas={
  {"What is (a+b)²?","Чему равно (a+b)²?",{"a²+2ab+b²","a²+b²","a²−2ab+b²"},{"a²+2ab+b²","a²+b²","a²−2ab+b²"},"Square of a sum.","Квадрат суммы."},
  {"What is (a−b)²?","Чему равно (a−b)²?",{"a²−2ab+b²","a²+2ab+b²","a²−b²"},{"a²−2ab+b²","a²+2ab+b²","a²−b²"},"Square of a difference.","Квадрат разности."},
  {"What is a² − b²?","Чему равно a² − b²?",{"(a−b)(a+b)","(a−b)²","(a+b)²"},{"(a−b)(a+b)","(a−b)²","(a+b)²"},"Difference of squares.","Разность квадратов."},
  {"What is (a+b)³?","Чему равно (a+b)³?",{"a³+3a²b+3ab²+b³","a³+b³","a³+3ab+b³"},{"a³+3a²b+3ab²+b³","a³+b³","a³+3ab+b³"},"Cube of a sum.","Куб суммы."},
  {"What is a³ + b³?","Чему равно a³ + b³?",{"(a+b)(a²−ab+b²)","(a+b)³","(a−b)(a²+ab+b²)"},{"(a+b)(a²−ab+b²)","(a+b)³","(a−b)(a²+ab+b²)"},"Sum of cubes.","Сумма кубов."},
  {"What is a³ − b³?","Чему равно a³ − b³?",{"(a−b)(a²+ab+b²)","(a+b)(a²−ab+b²)","(a−b)³"},{"(a−b)(a²+ab+b²)","(a+b)(a²−ab+b²)","(a−b)³"},"Difference of cubes.","Разность кубов."}
 }},
 {id="eq", name="Equations", ru="Уравнения", overview={
  "ax + b = c  ⇒  x = (c−b)/a","x = (−b ± √(b²−4ac)) / 2a","D = b² − 4ac","D > 0: two roots; D = 0: one repeated root; D < 0: no real roots","x² + bx = (x+b/2)² − (b/2)²"
 }, formulas={
  {"Quadratic formula for ax²+bx+c=0?","Формула корней ax²+bx+c=0?",{"(−b±√(b²−4ac))/2a","(b±√(b²−4ac))/2a","(−b±√(b²+4ac))/2a"},{"(−b±√(b²−4ac))/2a","(b±√(b²−4ac))/2a","(−b±√(b²+4ac))/2a"},"Standard quadratic formula.","Стандартная формула корней квадратного уравнения."},
  {"What is the discriminant D?","Чему равен дискриминант D?",{"b²−4ac","b²+4ac","−b±√(4ac)"},{"b²−4ac","b²+4ac","−b±√(4ac)"},"D = b² − 4ac.","D = b² − 4ac."},
  {"If D > 0, the quadratic has…","Если D > 0, квадратное уравнение имеет…",{"two distinct real roots","one real root","no real roots"},{"два различных действительных корня","один действительный корень","нет действительных корней"},"Positive discriminant gives two real roots.","Положительный дискриминант даёт два действительных корня."},
  {"If D = 0, the quadratic has…","Если D = 0, квадратное уравнение имеет…",{"one repeated real root","two real roots","no real roots"},{"один действительный корень","два действительных корня","нет действительных корней"},"Zero discriminant gives one repeated root.","Нулевой дискриминант даёт один кратный корень."},
  {"Solve for x: ax+b=c","Решите относительно x: ax+b=c",{"x=(c−b)/a","x=(c+b)/a","x=a/(c−b)"},{"x=(c−b)/a","x=(c+b)/a","x=a/(c−b)"},"Isolate x.","Выразите x."},
  {"Completing the square: x²+bx becomes?","Выделение полного квадрата: x²+bx = ?",{"(x+b/2)²−(b/2)²","(x+b)²","(x+b/2)²"},{"(x+b/2)²−(b/2)²","(x+b)²","(x+b/2)²"},"Add and subtract (b/2)².","Прибавьте и вычтите (b/2)²."}
 }},
 {id="log", name="Logarithms", ru="Логарифмы", overview={
  "logₐb = c  ⇔  aᶜ = b","logₐa = 1","logₐ1 = 0","logₐ(xy) = logₐx + logₐy","logₐ(x/y) = logₐx − logₐy","logₐ(xᵏ) = k logₐx","logₐb = log꜀b / log꜀a"
 }, formulas={
  {"logₐb = c means…","logₐb = c означает…",{"aᶜ = b","bᶜ = a","cᵃ = b"},{"aᶜ = b","bᶜ = a","cᵃ = b"},"Definition of logarithm.","Определение логарифма."},
  {"What is logₐa?","Чему равно logₐa?",{"1","0","a"},{"1","0","a"},"a¹ = a.","a¹ = a."},
  {"What is logₐ1?","Чему равно logₐ1?",{"0","1","undefined"},{"0","1","не определён"},"a⁰ = 1.","a⁰ = 1."},
  {"What is logₐ(xy)?","Чему равно logₐ(xy)?",{"logₐx + logₐy","logₐx · logₐy","logₐ(x+y)"},{"logₐx + logₐy","logₐx · logₐy","logₐ(x+y)"},"Product rule.","Свойство логарифма произведения."},
  {"What is logₐ(x/y)?","Чему равно logₐ(x/y)?",{"logₐx − logₐy","logₐx / logₐy","logₐ(x−y)"},{"logₐx − logₐy","logₐx / logₐy","logₐ(x−y)"},"Quotient rule.","Свойство логарифма частного."},
  {"What is logₐ(xᵏ)?","Чему равно logₐ(xᵏ)?",{"k logₐx","(logₐx)ᵏ","logₐx + k"},{"k logₐx","(logₐx)ᵏ","logₐx + k"},"Power rule.","Свойство логарифма степени."},
  {"Change of base formula?","Формула перехода к новому основанию?",{"log꜀b / log꜀a","log꜀b · log꜀a","log꜀(b−a)"},{"log꜀b / log꜀a","log꜀b · log꜀a","log꜀(b−a)"},"Change of base.","Переход к новому основанию."}
 }},
 {id="trig", name="Trigonometry", ru="Тригонометрия", overview={
  "sinθ = opp/hyp; cosθ = adj/hyp; tanθ = opp/adj","cscθ = 1/sinθ; secθ = 1/cosθ; cotθ = 1/tanθ","sin30°=1/2; cos30°=√3/2; tan30°=1/√3","sin45°=cos45°=√2/2; tan45°=1","sin60°=√3/2; cos60°=1/2; tan60°=√3","sin(90°−θ)=cosθ; cos(90°−θ)=sinθ","sin²θ+cos²θ=1","1+tan²θ=sec²θ; 1+cot²θ=csc²θ","sin2θ=2sinθcosθ; cos2θ=cos²θ−sin²θ","sin(A+B)=sinAcosB+cosAsinB","cos(A+B)=cosAcosB−sinAsinB"
 }, formulas={
  {"What is sin 30°?","Чему равен sin 30°?",{"1/2","√3/2","1"},{"1/2","√3/2","1"},"Standard trigonometric value.","Табличное значение."},
  {"What is cos 60°?","Чему равен cos 60°?",{"1/2","√3/2","0"},{"1/2","√3/2","0"},"Standard trigonometric value.","Табличное значение."},
  {"What is tan 45°?","Чему равен tan 45°?",{"1","0","√3"},{"1","0","√3"},"Standard trigonometric value.","Табличное значение."},
  {"What is sin²θ + cos²θ?","Чему равно sin²θ + cos²θ?",{"1","0","2"},{"1","0","2"},"Pythagorean identity.","Основное тригонометрическое тождество."},
  {"What is sin(90°−θ)?","Чему равно sin(90°−θ)?",{"cosθ","sinθ","−cosθ"},{"cosθ","sinθ","−cosθ"},"Co-function identity.","Формула приведения."},
  {"What is sin 2θ?","Чему равно sin 2θ?",{"2sinθcosθ","sin²θ","2sinθ"},{"2sinθcosθ","sin²θ","2sinθ"},"Double-angle formula.","Формула двойного угла."},
  {"What is cos 2θ?","Чему равно cos 2θ?",{"cos²θ−sin²θ","cos²θ+sin²θ","2cosθ"},{"cos²θ−sin²θ","cos²θ+sin²θ","2cosθ"},"Double-angle formula.","Формула двойного угла."},
  {"What is cscθ?","Чему равно cscθ?",{"1/sinθ","1/cosθ","1/tanθ"},{"1/sinθ","1/cosθ","1/tanθ"},"Reciprocal of sine.","Обратная величина синуса."},
  {"What is secθ?","Чему равно secθ?",{"1/cosθ","1/sinθ","1/tanθ"},{"1/cosθ","1/sinθ","1/tanθ"},"Reciprocal of cosine.","Обратная величина косинуса."},
  {"What is 1 + tan²θ?","Чему равно 1 + tan²θ?",{"sec²θ","csc²θ","1"},{"sec²θ","csc²θ","1"},"Pythagorean identity.","Основное тригонометрическое тождество."},
  {"sin(A+B) = ?","sin(A+B) = ?",{"sinAcosB+cosAsinB","sinAcosB−cosAsinB","cosAcosB−sinAsinB"},{"sinAcosB+cosAsinB","sinAcosB−cosAsinB","cosAcosB−sinAsinB"},"Angle-sum formula.","Формула суммы углов."},
  {"cos(A+B) = ?","cos(A+B) = ?",{"cosAcosB−sinAsinB","cosAcosB+sinAsinB","sinAcosB+cosAsinB"},{"cosAcosB−sinAsinB","cosAcosB+sinAsinB","sinAcosB+cosAsinB"},"Angle-sum formula.","Формула суммы углов."},
  {"What is tan 60°?","Чему равен tan 60°?",{"√3","1","1/√3"},{"√3","1","1/√3"},"Standard trigonometric value.","Табличное значение."},
  {"What is sin 45°?","Чему равен sin 45°?",{"√2/2","1/2","1"},{"√2/2","1/2","1"},"Standard trigonometric value.","Табличное значение."}
 }},
 {id="der", name="Derivatives", ru="Производные", overview={
  "(xⁿ)' = nxⁿ⁻¹","(c)' = 0","(f±g)' = f'±g'","(fg)' = f'g+fg'","(f/g)' = (f'g−fg')/g²","(f(g(x)))' = f'(g(x))·g'(x)","(sinx)'=cosx","(cosx)'=−sinx","(tanx)'=sec²x","(cotx)'=−csc²x","(secx)'=secx·tanx","(cscx)'=−cscx·cotx","(eˣ)'=eˣ","(aˣ)'=aˣlna","(lnx)'=1/x","(arcsinx)'=1/√(1−x²)","(arctanx)'=1/(1+x²)"
 }, formulas={
  {"(xⁿ)' = ?","(xⁿ)' = ?",{"nxⁿ⁻¹","xⁿ⁻¹","nxⁿ"},{"nxⁿ⁻¹","xⁿ⁻¹","nxⁿ"},"Power rule.","Правило степени."},
  {"(sin x)' = ?","(sin x)' = ?",{"cosx","−cosx","−sinx"},{"cosx","−cosx","−sinx"},"Standard derivative.","Стандартная производная."},
  {"(cos x)' = ?","(cos x)' = ?",{"−sinx","sinx","−cosx"},{"−sinx","sinx","−cosx"},"Standard derivative.","Стандартная производная."},
  {"(tan x)' = ?","(tan x)' = ?",{"sec²x","secx","−csc²x"},{"sec²x","secx","−csc²x"},"Standard derivative.","Стандартная производная."},
  {"(eˣ)' = ?","(eˣ)' = ?",{"eˣ","xeˣ⁻¹","e"},{"eˣ","xeˣ⁻¹","e"},"eˣ is its own derivative.","Производная eˣ равна eˣ."},
  {"(ln x)' = ?","(ln x)' = ?",{"1/x","eˣ","−1/x"},{"1/x","eˣ","−1/x"},"Standard derivative.","Стандартная производная."},
  {"Product rule (fg)' = ?","Правило произведения (fg)' = ?",{"f'g+fg'","f'g'","f'+g'"},{"f'g+fg'","f'g'","f'+g'"},"Product rule.","Правило произведения."},
  {"Quotient rule (f/g)' = ?","Правило частного (f/g)' = ?",{"(f'g−fg')/g²","(f'g+fg')/g²","f'/g'"},{"(f'g−fg')/g²","(f'g+fg')/g²","f'/g'"},"Quotient rule (minus in numerator).","Правило частного (минус в числителе)."},
  {"(sec x)' = ?","(sec x)' = ?",{"secx·tanx","sec²x","−secx·tanx"},{"secx·tanx","sec²x","−secx·tanx"},"Standard derivative.","Стандартная производная."},
  {"(cot x)' = ?","(cot x)' = ?",{"−csc²x","csc²x","−sec²x"},{"−csc²x","csc²x","−sec²x"},"Standard derivative.","Стандартная производная."},
  {"(aˣ)' = ?","(aˣ)' = ?",{"aˣ·lna","xaˣ⁻¹","aˣ"},{"aˣ·lna","xaˣ⁻¹","aˣ"},"Exponential with base a.","Показательная функция с основанием a."},
  {"(arcsin x)' = ?","(arcsin x)' = ?",{"1/√(1−x²)","1/(1+x²)","−1/√(1−x²)"},{"1/√(1−x²)","1/(1+x²)","−1/√(1−x²)"},"Standard inverse trigonometric derivative.","Стандартная производная обратной тригонометрической функции."},
  {"(arctan x)' = ?","(arctan x)' = ?",{"1/(1+x²)","1/√(1−x²)","−1/(1+x²)"},{"1/(1+x²)","1/√(1−x²)","−1/(1+x²)"},"Standard derivative.","Стандартная производная."},
  {"Derivative of a constant?","Производная константы?",{"0","the constant","1"},{"0","константа","1"},"The derivative of a constant is zero.","Производная константы равна нулю."},
  {"Chain rule: (f(g(x)))' = ?","Правило цепочки: (f(g(x)))' = ?",{"f'(g(x))·g'(x)","f'(x)·g'(x)","f(g'(x))"},{"f'(g(x))·g'(x)","f'(x)·g'(x)","f(g'(x))"},"Outside derivative × inside derivative.","Производная внешней функции × производная внутренней."}
 }},
 {id="int", name="Integrals", ru="Интегралы", overview={
  "∫xⁿ dx = xⁿ⁺¹/(n+1)+C  (n ≠ −1)","∫1/x dx = ln|x|+C","∫eˣ dx = eˣ+C","∫aˣ dx = aˣ/lna+C","∫sinx dx = −cosx+C","∫cosx dx = sinx+C","∫sec²x dx = tanx+C","∫csc²x dx = −cotx+C","∫secx·tanx dx = secx+C","∫1/√(1−x²) dx = arcsinx+C","∫1/(1+x²) dx = arctanx+C","∫ₐᵇf(x)dx = F(b)−F(a)"
 }, formulas={
  {"∫xⁿ dx (n≠−1) = ?","∫xⁿ dx (n≠−1) = ?",{"xⁿ⁺¹/(n+1)+C","nxⁿ⁻¹+C","xⁿ⁺¹+C"},{"xⁿ⁺¹/(n+1)+C","nxⁿ⁻¹+C","xⁿ⁺¹+C"},"Power rule for integrals.","Правило степени для интегралов."},
  {"∫(1/x) dx = ?","∫(1/x) dx = ?",{"ln|x|+C","−1/x²+C","x⁻¹+C"},{"ln|x|+C","−1/x²+C","x⁻¹+C"},"Special case: the power rule fails at n = −1.","Особый случай: правило степени не работает при n = −1."},
  {"∫eˣ dx = ?","∫eˣ dx = ?",{"eˣ+C","xeˣ⁻¹+C","e+C"},{"eˣ+C","xeˣ⁻¹+C","e+C"},"eˣ is its own antiderivative.","eˣ является собственной первообразной."},
  {"∫sinx dx = ?","∫sinx dx = ?",{"−cosx+C","cosx+C","−sinx+C"},{"−cosx+C","cosx+C","−sinx+C"},"Antiderivative of sin is −cos.","Первообразная синуса равна −cos."},
  {"∫cosx dx = ?","∫cosx dx = ?",{"sinx+C","−sinx+C","cosx+C"},{"sinx+C","−sinx+C","cosx+C"},"Antiderivative of cos is sin.","Первообразная косинуса равна sin."},
  {"∫sec²x dx = ?","∫sec²x dx = ?",{"tanx+C","secx+C","−cotx+C"},{"tanx+C","secx+C","−cotx+C"},"Derivative of tan is sec².","Производная тангенса равна sec²."},
  {"∫1/(1+x²) dx = ?","∫1/(1+x²) dx = ?",{"arctanx+C","arcsinx+C","ln|1+x²|+C"},{"arctanx+C","arcsinx+C","ln|1+x²|+C"},"Standard inverse trigonometric integral.","Стандартный интеграл обратной тригонометрической функции."},
  {"∫1/√(1−x²) dx = ?","∫1/√(1−x²) dx = ?",{"arcsinx+C","arctanx+C","ln|√(1−x²)|+C"},{"arcsinx+C","arctanx+C","ln|√(1−x²)|+C"},"Standard integral.","Стандартный интеграл."},
  {"Definite integral ∫ₐᵇf dx = ?","Определённый интеграл ∫ₐᵇf dx = ?",{"F(b)−F(a)","F(a)−F(b)","F(b)+F(a)"},{"F(b)−F(a)","F(a)−F(b)","F(b)+F(a)"},"Fundamental theorem of calculus.","Формула Ньютона — Лейбница."},
  {"∫aˣ dx = ?","∫aˣ dx = ?",{"aˣ/lna+C","aˣ·lna+C","xaˣ⁻¹+C"},{"aˣ/lna+C","aˣ·lna+C","xaˣ⁻¹+C"},"Standard integral.","Стандартный интеграл."},
  {"∫csc²x dx = ?","∫csc²x dx = ?",{"−cotx+C","cotx+C","−tanx+C"},{"−cotx+C","cotx+C","−tanx+C"},"Derivative of cot is −csc².","Производная котангенса равна −csc²."},
  {"∫secx·tanx dx = ?","∫secx·tanx dx = ?",{"secx+C","tanx+C","−secx+C"},{"secx+C","tanx+C","−secx+C"},"Derivative of sec is sec·tan.","Производная секанса равна sec·tan."}
 }}
}

function Data.GetTopic(id)
 for _, topic in ipairs(Data.Topics) do if topic.id == id then return topic end end
end

local function shuffled(items)
 local copy = table.clone(items)
 for i = #copy, 2, -1 do
  local j = math.random(1, i)
  copy[i], copy[j] = copy[j], copy[i]
 end
 return copy
end

local function makeQuestion(prompt, answer, wrong1, wrong2, explanation, promptRu, explanationRu)
 local options = {tostring(answer), tostring(wrong1), tostring(wrong2)}
 local seen = {}
 for _, value in ipairs(options) do
  if seen[value] then return nil end
  seen[value] = true
 end
 return {q=prompt, qRu=promptRu or prompt, o=options, oRu=options, a=1, e=explanation, eRu=explanationRu or explanation}
end

function Data.GeneratePractice(topicId, index)
 local a = math.random(2,7)
 local b = math.random(2,6)
 if math.abs(b-a) <= 1 then b = a <= 4 and a+2 or a-2 end
 local n = math.random(2,4)
 local x = n+2
 local angle = ({30,45,60})[math.random(1,3)]
 local topic = Data.GetTopic(topicId)
 local function q(prompt, answer, wrong1, wrong2, explanation)
  local result = makeQuestion(prompt, answer, wrong1, wrong2, explanation)
  if result then return result end
 end

 if topicId == "sqrt" then
  if index == 1 then return q("Simplify √("..(a*a).." · "..(b*b)..").",a*b,a*b+1,a*b-1,"Take the square roots of both factors.") end
  if index == 2 then return q("Evaluate √("..(a*a).."/"..(b*b)..").",a.."/"..b,(a+1).."/"..b,a.."/"..(b+1),"Take the square root of numerator and denominator.") end
  if index == 3 then return q("Evaluate √((−"..a..")²).",a,a+1,-a,"The principal square root is non-negative.") end
  return q("Evaluate (√"..(a*a)..")².",a*a,a*a+1,a,"Squaring the root returns the radicand.")
 elseif topicId == "pow" then
  if index == 1 then return q("Simplify 2^"..a.." · 2^"..b..".","2^"..(a+b),"2^"..(a*b),"2^"..(a-b),"Add exponents.") end
  if index == 2 then return q("Simplify 3^"..(a+b).." / 3^"..b..".","3^"..a,"3^"..(a+b),"3^"..b,"Subtract exponents.") end
  if index == 3 then return q("Simplify (2^"..a..")^"..b..".","2^"..(a*b),"2^"..(a+b),"2^"..a,"Multiply exponents.") end
  if index == 4 then return q("Evaluate "..a.."^0.",1,0,a,"Any non-zero number to power zero is 1.") end
  if index == 5 then return q("Evaluate 2^(−"..a..").","1/"..(2^a),"-"..(2^a),"1/2","A negative exponent means reciprocal.") end
  return q("Evaluate (2 · 3)^"..a..".",6^a,2^a+3^a,6*a,"Apply the power to both factors.")
 elseif topicId == "binom" then
  if index == 1 then return q("Evaluate ("..a.."+"..b..")².",(a+b)^2,a*a+b*b,(a-b)^2,"Use the square-of-a-sum formula.") end
  if index == 2 then return q("Evaluate ("..a.."−"..b..")².",(a-b)^2,a*a+b*b,(a+b)^2,"Use the square-of-a-difference formula.") end
  if index == 3 then return q("Evaluate "..(a*a).."−"..(b*b)..".",(a-b)*(a+b),a*a+b*b,(a-b)^2,"Difference of squares.") end
  if index == 4 then return q("Evaluate ("..a.."+"..b..")³.",(a+b)^3,a^3+b^3,(a+b)^2,"Cube of a sum.") end
  if index == 5 then return q("Evaluate ("..a.."−"..b..")³.",(a-b)^3,a^3-b^3,(a-b)^2,"Cube of a difference.") end
  return q("Evaluate "..a.."³+"..b.."³.",a^3+b^3,(a+b)^3,a^3-b^3,"Substitute into the sum of cubes.")
 elseif topicId == "eq" then
  if index == 1 then
   local r1,r2 = math.random(1,4),math.random(2,5)
   return q("Solve x²−"..(r1+r2).."x+"..(r1*r2).."=0.",r1..", "..r2,r1..", "..(r2+1),(r1+1)..", "..r2,"The roots are "..r1.." and "..r2..".")
  elseif index == 2 then
   local d = b*b-4*a
   return q("For x²+"..b.."x+"..a.."=0, calculate D.",d,b*b+4*a,b*b,"D = b² − 4ac.")
  elseif index == 3 then return q("A quadratic has D = "..a..". How many distinct real roots?",2,1,0,"Positive discriminant gives two roots.")
  elseif index == 4 then return q("A quadratic has D = 0. How many distinct real roots?",1,2,0,"Zero discriminant gives one repeated root.")
  elseif index == 5 then return q("Solve "..a.."x+"..b.."="..(a*x+b)..".",x,x+1,x-1,"Subtract b, then divide by a.")
  end
  return q("Complete the square in x²+"..(2*a).."x. What constant is subtracted?",a*a,a,2*a+1,"Subtract (b/2)².")
 elseif topicId == "log" then
  if index == 1 then return q("If log₂ "..(2^n).."=c, find c.",n,n+1,n-1,"2 to the power "..n.." equals "..(2^n)..".")
  elseif index == 2 then return q("Evaluate log_"..a.." "..a..".",1,0,a,"The logarithm of its base is 1.")
  elseif index == 3 then return q("Evaluate log_"..a.." 1.",0,1,a,"a to power zero is 1.")
  elseif index == 4 then return q("Evaluate log₂(2^"..a.." · 2^"..b..").",a+b,a*b,a-b,"The product rule adds logarithms.")
  elseif index == 5 then return q("Evaluate log₂(2^"..a.." / 2^"..b..").",a-b,a+b,a*b,"The quotient rule subtracts logarithms.")
  elseif index == 6 then return q("Evaluate log₂((2^"..a..")^"..b..").",a*b,a+b,a-b,"Move the exponent in front.")
  end
  return q("Evaluate log₂ "..(2^n)..".",n,n+1,1,"2 to the power "..n.." equals "..(2^n)..".")
 elseif topicId == "trig" then
  local sin = ({["30"]="1/2",["45"]="√2/2",["60"]="√3/2"})[tostring(angle)]
  local cos = ({["30"]="√3/2",["45"]="√2/2",["60"]="1/2"})[tostring(angle)]
  local tan = ({["30"]="1/√3",["45"]="1",["60"]="√3"})[tostring(angle)]
  if index == 1 then return q("Evaluate sin "..angle.."°.",sin,"1","0","Use the standard-angle table.")
  elseif index == 2 then return q("Evaluate cos "..angle.."°.",cos,"1","0","Use the standard-angle table.")
  elseif index == 3 then return q("Evaluate tan "..angle.."°.",tan,"0","2","Use the standard-angle table.")
  elseif index == 4 then return q("If sinθ and cosθ are from a right triangle, find sin²θ+cos²θ.",1,0,2,"The Pythagorean identity equals 1.")
  elseif index == 5 then return q("Evaluate sin(90°−"..angle.."°).",cos,"1","0","Use the co-function identity.")
  elseif index == 6 then return q("If sinθ="..a.."/"..(a+b)..", cosθ="..b.."/"..(a+b)..", find 2sinθcosθ.",2*a*b/(a+b)^2,a*b/(a+b)^2,(a+b)/(a*b),"Multiply 2 × sinθ × cosθ.")
  end
  return q("Evaluate sin "..angle.."°.",sin,"1","0","Use the standard-angle table.")
 elseif topicId == "der" then
  if index == 1 then return q("If f(x)=x^"..n..", find f'("..x..").",n*x^(n-1),(n+1)*x^(n-1),x^n,"Apply the power rule.")
  elseif index == 2 then return q("Find derivative of sin x at "..angle.."°.",cos,"1","0","The derivative is cos x.")
  elseif index == 3 then return q("Find derivative of cos x at "..angle.."°.",({["30"]="-1/2",["45"]="-√2/2",["60"]="-√3/2"})[tostring(angle)],"0","1","The derivative is −sin x.")
  elseif index == 4 then return q("Find derivative of eˣ at x="..(n%2)..".",(n%2)==0 and "1" or "e","0","e","The derivative of eˣ is eˣ.")
  elseif index == 5 then return q("Find derivative of ln x at x="..x..".","1/"..x,"1/"..(x+1),"1/"..(x-1),"The derivative is 1/x.")
  elseif index == 6 then
   local f,g,fp,gp = math.random(2,6),math.random(3,7),math.random(2,6),math.random(1,3)
   return q("If f="..f..", g="..g..", f'="..fp..", g'="..gp..", find (fg)'.",fp*g+f*gp,fp+gp,fp*g-f*gp,"Product rule: f'g + fg'.")
  end
  return q("Derivative of the constant "..a..".",0,1,a,"The derivative of a constant is zero.")
 elseif topicId == "int" then
  if index == 1 then return q("For n="..n..", evaluate x^(n+1)/(n+1) at x="..x..".",x^(n+1).."/"..(n+1),x^n.."/"..n,x^(n+1).."/"..n,"Substitute into the power-rule antiderivative.")
  elseif index == 2 then return q("Evaluate ln|x| at x="..x..".","ln "..x,"ln "..(x+1),"ln "..(x-1),"Substitute the generated positive x.")
  elseif index == 3 then return q("Evaluate eˣ at x="..(n%2)..".",(n%2)==0 and "1" or "e","0","e","Substitute the generated exponent.")
  elseif index == 4 then return q("Evaluate −cos "..angle.."°.",({["30"]="-√3/2",["45"]="-√2/2",["60"]="-1/2"})[tostring(angle)],"0","-1","Substitute the generated angle.")
  elseif index == 5 then return q("Evaluate sin "..angle.."°.",sin,"0","1","Substitute the generated angle.")
  elseif index == 6 then return q("Evaluate tan "..angle.."°.",tan,"0","2","Substitute the generated angle.")
  end
  return q("If F(2)="..(a+b).." and F(1)="..a..", find the definite integral from 1 to 2.",b,b+1,a-b,"Use F(2) − F(1).")
 end
 return topic.formulas[index]
end

function Data.BuildSession(scope)
 local formulaItems, practiceItems = {}, {}
 local topics = scope == "all" and Data.Topics or {Data.GetTopic(string.gsub(scope, "^topic:", ""))}
 for _, topic in ipairs(topics) do
  for i=1,#topic.formulas do
   table.insert(formulaItems,{topic=topic.id,index=i,phase="formula",key=topic.id.."-f-"..i})
   table.insert(practiceItems,{topic=topic.id,index=i,phase="instance",key=topic.id.."-i-"..i})
  end
 end
 formulaItems = shuffled(formulaItems)
 practiceItems = shuffled(practiceItems)
 for _, item in ipairs(formulaItems) do item.question = Data.GetTopic(item.topic).formulas[item.index] end
 for _, item in ipairs(practiceItems) do item.question = Data.GeneratePractice(item.topic,item.index) or Data.GetTopic(item.topic).formulas[item.index] end
 for _, item in ipairs(practiceItems) do table.insert(formulaItems,item) end
 return formulaItems
end

function Data.Shuffle(items) return shuffled(items) end
return Data
